Date: Thu, 19 Aug 1999 10:03:50 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Hank De Gregorio <hcd1@acpub.duke.edu>
cc: Don Holmgren <djholm@fnal.gov>, paubert@iram.es,
        linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: SCSI problem on PPC1Bug FW system
In-Reply-To: <Pine.SOL.3.91.990818164559.517B-100000@godzilla6.acpub.duke.edu>
Message-ID: <Pine.LNX.4.10.9908191001590.8446-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Aug 1999, Hank De Gregorio wrote:
> when booting one of gabriel's installation kernels (zImage.initrd-2.2.4),
> i got the following error.  my scsi drive was recognized, but there is a
> "parity error" when it is being initialized.  is this just a matter of
> needing a wide active terminator for my scsi? 
> 
> hank (thanks, don, for helping get me past the last problem; i needed to 
> disable VME3PCI Master Master)
> 
> --snip
> ncr53c825a-0: Downloading SCSI SCRIPTS.
> scsi0 : ncr53c8xx - version 3.2
> scsi : 1 host.
>   Vendor: SEAGATE   Model: ST39175LW         Rev: 0001
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
> ncr53c825a-0-<0,0>: tagged command queue depth set to 8
> scsi : detected 1 SCSI disk total.
> ncr53c825a-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)
> ncr53c825a-0: SCSI parity error detected: SCR1=3 DBC=19000000 SSTAT1=9
> ncr53c825a-0:0: ERROR (81:0) (6-a3-2) (8/1b) @ (scripth ba0:48000000).
> ncr53c825a-0: script cmd = 785d8700
> ncr53c825a-0: regdump: da 10 00 1b 47 08 00 0f 06 06 80 a3 80 00 0b 00.
> ncr53c825a-0: have to clear fifos.
> ncr53c825a-0: restart (scsi reset).
> ncr53c825a-0: Downloading SCSI SCRIPTS.
> ncr53c825a-0: SCSI parity error detected: SCR1=1 DBC=19000000 SSTAT1=1
> ncr53c825a-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)

It's probably a cable/termination problem.

Or have you connected your wide devices to the narrow connector on the adapter
using a wide-narrow convertor? I once did that when I didn't have a wide cable,
and it caused the same problems (driver negotiates wide transfers since it
recognizes a wide device).

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
