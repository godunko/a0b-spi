--
--  Copyright (C) 2024-2025, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

with System;

with A0B.Callbacks;
with A0B.Types;

package A0B.SPI
  with Preelaborate
is

   type Buffer_Descriptor is record
      Address     : System.Address;
      Size        : A0B.Types.Unsigned_32;
      Transferred : A0B.Types.Unsigned_32;
      State       : A0B.Operation_Status;
   end record;
   --  Descriptor of the transmit/receive buffer.
   --
   --  @component Address      Address of the first byte of the buffer memory
   --  @component Size         Size of the buffer in bytes
   --  @component Transferred  Number of byte transferred by the operation
   --  @component State        State of the operation

   type Buffer_Descriptor_Array is
     array (A0B.Types.Unsigned_32 range <>) of aliased Buffer_Descriptor;

   --   type SPI_Slave_Device is tagged;

   --   type SPI_Master_Port is limited interface;

   --  not overriding procedure Select_Device
   --    (Self   : in out SPI_Bus;
   --     Device : not null access SPI_Device'Class) is abstract;

   --  type SPI_Device (Bus : not null access SPI_Bus'Class) is
   --    abstract tagged limited null record;

   type SPI_Slave_Device is limited interface;

   not overriding procedure Transfer
     (Self              : in out SPI_Slave_Device;
      Transmit_Buffer   : aliased A0B.Types.Unsigned_8;
      Receive_Buffer    : aliased out A0B.Types.Unsigned_8;
      Finished_Callback : A0B.Callbacks.Callback;
      Success           : in out Boolean) is abstract;
   --  Transmit and receive data to/from the device. Given callback will be
   --  called when transmission is done.

   not overriding procedure Transmit
     (Self              : in out SPI_Slave_Device;
      Transmit_Buffer   : aliased A0B.Types.Unsigned_8;
      Finished_Callback : A0B.Callbacks.Callback;
      Success           : in out Boolean) is abstract;
   --  Transmit data to/from the device. Received data is ignored. Given
   --  callback will be called when transmission is done.

   not overriding procedure Select_Device
     (Self : in out SPI_Slave_Device) is abstract;

   not overriding procedure Release_Device
     (Self : in out SPI_Slave_Device) is abstract;

   not overriding procedure Transmit
     (Self             : in out SPI_Slave_Device;
      Transmit_Buffers : in out A0B.SPI.Buffer_Descriptor_Array;
      On_Finished      : A0B.Callbacks.Callback;
      Success          : in out Boolean) is abstract;
   --  Transmit data to/from the device. Received data is ignored. Given
   --  callback will be called when transmission is done.

   not overriding procedure Receive
     (Self            : in out SPI_Slave_Device;
      --  Transmit_Placeholder : A0B.Types.Unsigned_8;
      Receive_Buffers : in out A0B.SPI.Buffer_Descriptor_Array;
      On_Finished     : A0B.Callbacks.Callback;
      Success         : in out Boolean) is abstract;
   --  Receive data to/from the device. Transmitted data is zeros. Given
   --  callback will be called when transmission is done.

   --  type SPI_Software_Selection_Controlled_Slave_Device is limited interface
   --    and SPI_Slave_Device;

   --  not overriding procedure Select_Device
   --    (Self : in out SPI_Software_Selected_Slave_Device) is abstract;

   --  not overriding procedure Release_Device
   --    (Self              : in out SPI_Software_Selected_Slave_Device;
   --     Released_Callback : A0B.Callbacks.Callback) is abstract;

end A0B.SPI;
