--
--  Copyright (C) 2024, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Restrictions (No_Elaboration_Code);

with A0B.Callbacks;
with A0B.Types;

package A0B.SPI
  with Preelaborate
is

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
      Finished_Callback : A0B.Callbacks.Callback) is abstract;
   --  Transmit and receive data to/from the device. Call callback when
   --  transmission is done.

   not overriding procedure Transmit
     (Self              : in out SPI_Slave_Device;
      Transmit_Buffer   : aliased A0B.Types.Unsigned_8;
      Finished_Callback : A0B.Callbacks.Callback) is abstract;

   --  type SPI_Software_Selection_Controlled_Slave_Device is limited interface
   --    and SPI_Slave_Device;

   --  not overriding procedure Select_Device
   --    (Self : in out SPI_Software_Selected_Slave_Device) is abstract;

   --  not overriding procedure Release_Device
   --    (Self              : in out SPI_Software_Selected_Slave_Device;
   --     Released_Callback : A0B.Callbacks.Callback) is abstract;

end A0B.SPI;
