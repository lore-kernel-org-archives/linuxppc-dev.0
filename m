Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 0EDB6DDF1E
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 21:56:54 +1100 (EST)
Date: Fri, 2 Mar 2007 11:44:45 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] typos in booting-without-of.txt
Message-ID: <20070302104445.GT4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix typos + some cosmetic changes.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 Documentation/powerpc/booting-without-of.txt |   82 +++++++++++++--------------
 1 file changed, 40 insertions(+), 42 deletions(-)

Index: grant.git/Documentation/powerpc/booting-without-of.txt
===================================================================
--- grant.git.orig/Documentation/powerpc/booting-without-of.txt
+++ grant.git/Documentation/powerpc/booting-without-of.txt
@@ -39,7 +39,7 @@
                            and property data. The old style variable
                            alignment would make it impossible to do
                            "simple" insertion of properties using
-                           memove (thanks Milton for
+                           memmove (thanks Milton for
                            noticing). Updated kernel patch as well
 			 - Correct a few more alignment constraints
 			 - Add a chapter about the device-tree
@@ -55,7 +55,7 @@
 
  ToDo:
 	- Add some definitions of interrupt tree (simple/complex)
-	- Add some definitions for pci host bridges
+	- Add some definitions for PCI host bridges
 	- Add some common address format examples
 	- Add definitions for standard properties and "compatible"
 	  names for cells that are not already defined by the existing
@@ -114,7 +114,7 @@ it with special cases.
         forth words isn't required), you can enter the kernel with:
 
               r5 : OF callback pointer as defined by IEEE 1275
-              bindings to powerpc. Only the 32 bit client interface
+              bindings to powerpc. Only the 32-bit client interface
               is currently supported
 
               r3, r4 : address & length of an initrd if any or 0
@@ -194,7 +194,7 @@ it with special cases.
   for this is to keep kernels on embedded systems small and efficient;
   part of this is due to the fact the code is already that way. In the
   future, a kernel may support multiple platforms, but only if the
-  platforms feature the same core architectire.  A single kernel build
+  platforms feature the same core architecture.  A single kernel build
   cannot support both configurations with Book E and configurations
   with classic Powerpc architectures.
 
@@ -215,7 +215,7 @@ of the boot sequences.... someone speak 
   enable another config option to select the specific board
   supported.
 
-NOTE: If ben doesn't merge the setup files, may need to change this to
+NOTE: If Ben doesn't merge the setup files, may need to change this to
 point to setup_32.c
 
 
@@ -256,7 +256,7 @@ struct boot_param_header {
         u32     off_dt_struct;          /* offset to structure */
         u32     off_dt_strings;         /* offset to strings */
         u32     off_mem_rsvmap;         /* offset to memory reserve map
-*/
+                                           */
         u32     version;                /* format version */
         u32     last_comp_version;      /* last compatible version */
 
@@ -273,7 +273,7 @@ struct boot_param_header {
 #define OF_DT_HEADER            0xd00dfeed      /* 4: version,
 						   4: total size */
 #define OF_DT_BEGIN_NODE        0x1             /* Start node: full name
-*/
+						   */
 #define OF_DT_END_NODE          0x2             /* End node */
 #define OF_DT_PROP              0x3             /* Property: name off,
                                                    size, content */
@@ -310,9 +310,8 @@ struct boot_param_header {
    - off_mem_rsvmap
 
      This is an offset from the beginning of the header to the start
-     of the reserved memory map. This map is a list of pairs of 64
+     of the reserved memory map. This map is a list of pairs of 64-
      bit integers. Each pair is a physical address and a size. The
-
      list is terminated by an entry of size 0. This map provides the
      kernel with a list of physical memory areas that are "reserved"
      and thus not to be used for memory allocations, especially during
@@ -325,7 +324,7 @@ struct boot_param_header {
      contain _at least_ this DT block itself (header,total_size). If
      you are passing an initrd to the kernel, you should reserve it as
      well. You do not need to reserve the kernel image itself. The map
-     should be 64 bit aligned.
+     should be 64-bit aligned.
 
    - version
 
@@ -461,7 +460,7 @@ referencing another node via "phandle" i
 interrupt tree which will be described in a further version of this
 document.
 
-This "linux, phandle" property is a 32 bit value that uniquely
+This "linux, phandle" property is a 32-bit value that uniquely
 identifies a node. You are free to use whatever values or system of
 values, internal pointers, or whatever to generate these, the only
 requirement is that every node for which you provide that property has
@@ -471,7 +470,7 @@ Here is an example of a simple device-tr
 designates a node followed by the node unit name. Properties are
 presented with their name followed by their content. "content"
 represents an ASCII string (zero terminated) value, while <content>
-represents a 32 bit hexadecimal value. The various nodes in this
+represents a 32-bit hexadecimal value. The various nodes in this
 example will be discussed in a later chapter. At this point, it is
 only meant to give you a idea of what a device-tree looks like. I have
 purposefully kept the "name" and "linux,phandle" properties which
@@ -543,15 +542,15 @@ Here's the basic structure of a single n
      * [align gap to next 4 bytes boundary]
      * for each property:
         * token OF_DT_PROP (that is 0x00000003)
-        * 32 bit value of property value size in bytes (or 0 of no
-     * value)
-        * 32 bit value of offset in string block of property name
+        * 32-bit value of property value size in bytes (or 0 of no
+          value)
+        * 32-bit value of offset in string block of property name
         * property value data if any
         * [align gap to next 4 bytes boundary]
      * [child nodes if any]
      * token OF_DT_END_NODE (that is 0x00000002)
 
-So the node content can be summarised as a start token, a full path,
+So the node content can be summarized as a start token, a full path,
 a list of properties, a list of child nodes, and an end token. Every
 child node is a full node structure itself as defined above.
 
@@ -583,7 +582,7 @@ provide those properties yourself.
 ----------------------------------------------
 
 The general rule is documented in the various Open Firmware
-documentations. If you chose to describe a bus with the device-tree
+documentations. If you choose to describe a bus with the device-tree
 and there exist an OF bus binding, then you should follow the
 specification. However, the kernel does not require every single
 device or bus to be described by the device tree.
@@ -596,9 +595,9 @@ those properties defining addresses form
 on the processor bus.
 
 Those 2 properties define 'cells' for representing an address and a
-size. A "cell" is a 32 bit number. For example, if both contain 2
+size. A "cell" is a 32-bit number. For example, if both contain 2
 like the example tree given above, then an address and a size are both
-composed of 2 cells, and each is a 64 bit number (cells are
+composed of 2 cells, and each is a 64-bit number (cells are
 concatenated and expected to be in big endian format). Another example
 is the way Apple firmware defines them, with 2 cells for an address
 and one cell for a size.  Most 32-bit implementations should define
@@ -632,7 +631,7 @@ prom_parse.c file of the recent kernels 
 
 The "reg" property only defines addresses and sizes (if #size-cells
 is non-0) within a given bus. In order to translate addresses upward
-(that is into parent bus addresses, and possibly into cpu physical
+(that is into parent bus addresses, and possibly into CPU physical
 addresses), all busses must contain a "ranges" property. If the
 "ranges" property is missing at a given level, it's assumed that
 translation isn't possible. The format of the "ranges" property for a
@@ -648,9 +647,9 @@ example, for a PCI host controller, that
 PCI<->ISA bridge, that would be a PCI address. It defines the base
 address in the parent bus where the beginning of that range is mapped.
 
-For a new 64 bit powerpc board, I recommend either the 2/2 format or
+For a new 64-bit powerpc board, I recommend either the 2/2 format or
 Apple's 2/1 format which is slightly more compact since sizes usually
-fit in a single 32 bit word.   New 32 bit powerpc boards should use a
+fit in a single 32-bit word.   New 32-bit powerpc boards should use a
 1/1 format, unless the processor supports physical addresses greater
 than 32-bits, in which case a 2/1 format is recommended.
 
@@ -764,13 +763,13 @@ address which can extend beyond that lim
   Required properties:
 
     - device_type : has to be "cpu"
-    - reg : This is the physical cpu number, it's a single 32 bit cell
+    - reg : This is the physical CPU number, it's a single 32-bit cell
       and is also used as-is as the unit number for constructing the
       unit name in the full path. For example, with 2 CPUs, you would
       have the full path:
         /cpus/PowerPC,970FX@0
         /cpus/PowerPC,970FX@1
-      (unit addresses do not require leading zeroes)
+      (unit addresses do not require leading zeros)
     - d-cache-line-size : one cell, L1 data cache line size in bytes
     - i-cache-line-size : one cell, L1 instruction cache line size in
       bytes
@@ -785,7 +784,7 @@ address which can extend beyond that lim
       the kernel timebase/decrementer calibration based on this
       value.
     - clock-frequency : a cell indicating the CPU core clock frequency
-      in Hz. A new property will be defined for 64 bit values, but if
+      in Hz. A new property will be defined for 64-bit values, but if
       your frequency is < 4Ghz, one cell is enough. Here as well as
       for the above, the common code doesn't use that property, but
       you are welcome to re-use the pSeries or Maple one. A future
@@ -908,8 +907,7 @@ address which can extend beyond that lim
   The SOC node may contain child nodes for each SOC device that the
   platform uses.  Nodes should not be created for devices which exist
   on the SOC but are not used by a particular platform. See chapter VI
-  for more information on how to specify devices that are part of an
-SOC.
+  for more information on how to specify devices that are part of a SOC.
 
   Example SOC node for the MPC8540:
 
@@ -972,7 +970,7 @@ The syntax of the dtc tool is
         [-o output-filename] [-V output_version] input_filename
 
 
-The "output_version" defines what versio of the "blob" format will be
+The "output_version" defines what version of the "blob" format will be
 generated. Supported versions are 1,2,3 and 16. The default is
 currently version 3 but that may change in the future to version 16.
 
@@ -994,12 +992,12 @@ supported currently at the toplevel.
 				 */
 
   property2 = <1234abcd>;	/* define a property containing a
-                                 * numerical 32 bits value (hexadecimal)
+                                 * numerical 32-bit value (hexadecimal)
 				 */
 
   property3 = <12345678 12345678 deadbeef>;
                                 /* define a property containing 3
-                                 * numerical 32 bits values (cells) in
+                                 * numerical 32-bit values (cells) in
                                  * hexadecimal
 				 */
   property4 = [0a 0b 0c 0d de ea ad be ef];
@@ -1068,7 +1066,7 @@ while all this has been defined and impl
     its usage in early_init_devtree(), and the corresponding various
     early_init_dt_scan_*() callbacks. That code can be re-used in a
     GPL bootloader, and as the author of that code, I would be happy
-    to discuss possible free licencing to any vendor who wishes to
+    to discuss possible free licensing to any vendor who wishes to
     integrate all or part of this code into a non-GPL bootloader.
 
 
@@ -1077,7 +1075,7 @@ VI - System-on-a-chip devices and nodes
 =======================================
 
 Many companies are now starting to develop system-on-a-chip
-processors, where the processor core (cpu) and many peripheral devices
+processors, where the processor core (CPU) and many peripheral devices
 exist on a single piece of silicon.  For these SOCs, an SOC node
 should be used that defines child nodes for the devices that make
 up the SOC. While platforms are not required to use this model in
@@ -1312,10 +1310,10 @@ platforms are moved over to use the flat
    and additions :  
 
    Required properties :
-    - compatible : Should be "fsl-usb2-mph" for multi port host usb
-      controllers, or "fsl-usb2-dr" for dual role usb controllers
-    - phy_type : For multi port host usb controllers, should be one of
-      "ulpi", or "serial". For dual role usb controllers, should be
+    - compatible : Should be "fsl-usb2-mph" for multi port host USB
+      controllers, or "fsl-usb2-dr" for dual role USB controllers
+    - phy_type : For multi port host USB controllers, should be one of
+      "ulpi", or "serial". For dual role USB controllers, should be
       one of "ulpi", "utmi", "utmi_wide", or "serial".
     - reg : Offset and length of the register set for the device
     - port0 : boolean; if defined, indicates port0 is connected for
@@ -1339,7 +1337,7 @@ platforms are moved over to use the flat
     - interrupt-parent : the phandle for the interrupt controller that
       services interrupts for this device.
 
-   Example multi port host usb controller device node : 
+   Example multi port host USB controller device node :
 	usb@22000 {
 	        device_type = "usb";
 		compatible = "fsl-usb2-mph";
@@ -1353,7 +1351,7 @@ platforms are moved over to use the flat
 		port1;
 	};
 
-   Example dual role usb controller device node : 
+   Example dual role USB controller device node :
 	usb@23000 {
 		device_type = "usb";
 		compatible = "fsl-usb2-dr";
@@ -1387,7 +1385,7 @@ platforms are moved over to use the flat
     - channel-fifo-len : An integer representing the number of
       descriptor pointers each channel fetch fifo can hold.
     - exec-units-mask : The bitmask representing what execution units
-      (EUs) are available. It's a single 32 bit cell. EU information
+      (EUs) are available. It's a single 32-bit cell. EU information
       should be encoded following the SEC's Descriptor Header Dword
       EU_SEL0 field documentation, i.e. as follows:
 
@@ -1403,7 +1401,7 @@ platforms are moved over to use the flat
       bits 8 through 31 are reserved for future SEC EUs.
 
     - descriptor-types-mask : The bitmask representing what descriptors
-      are available. It's a single 32 bit cell. Descriptor type
+      are available. It's a single 32-bit cell. Descriptor type
       information should be encoded following the SEC's Descriptor
       Header Dword DESC_TYPE field documentation, i.e. as follows:
 
@@ -1492,7 +1490,7 @@ platforms are moved over to use the flat
    Required properties:
    - device_type : should be "spi".
    - compatible : should be "fsl_spi".
-   - mode : the spi operation mode, it can be "cpu" or "qe".
+   - mode : the SPI operation mode, it can be "cpu" or "qe".
    - reg : Offset and length of the register set for the device
    - interrupts : <a b> where a is the interrupt number and b is a
      field that represents an encoding of the sense and level
@@ -1712,7 +1710,7 @@ platforms are moved over to use the flat
      - partitions : Several pairs of 32-bit values where the first value is
        partition's offset from the start of the device and the second one is
        partition size in bytes with LSB used to signify a read only
-       partition (so, the parition size should always be an even number).
+       partition (so, the partition size should always be an even number).
      - partition-names : The list of concatenated zero terminated strings
        representing the partition names.
      - probe-type : The type of probe which should be done for the chip
