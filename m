Date: Wed, 18 Aug 1999 17:17:17 -0400 (EDT)
From: Hank De Gregorio <hcd1@acpub.duke.edu>
To: Don Holmgren <djholm@fnal.gov>
cc: paubert@iram.es, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: SCSI problem on PPC1Bug FW system
In-Reply-To: <Pine.SGI.3.91.990812144057.4774A-100000@fndaub.fnal.gov>
Message-ID: <Pine.SOL.3.91.990818164559.517B-100000@godzilla6.acpub.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


when booting one of gabriel's installation kernels (zImage.initrd-2.2.4),
i got the following error.  my scsi drive was recognized, but there is a
"parity error" when it is being initialized.  is this just a matter of
needing a wide active terminator for my scsi? 

hank (thanks, don, for helping get me past the last problem; i needed to 
disable VME3PCI Master Master)

--snip
ncr53c825a-0: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - version 3.2
scsi : 1 host.
  Vendor: SEAGATE   Model: ST39175LW         Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
ncr53c825a-0-<0,0>: tagged command queue depth set to 8
scsi : detected 1 SCSI disk total.
ncr53c825a-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)
ncr53c825a-0: SCSI parity error detected: SCR1=3 DBC=19000000 SSTAT1=9
ncr53c825a-0:0: ERROR (81:0) (6-a3-2) (8/1b) @ (scripth ba0:48000000).
ncr53c825a-0: script cmd = 785d8700
ncr53c825a-0: regdump: da 10 00 1b 47 08 00 0f 06 06 80 a3 80 00 0b 00.
ncr53c825a-0: have to clear fifos.
ncr53c825a-0: restart (scsi reset).
ncr53c825a-0: Downloading SCSI SCRIPTS.
ncr53c825a-0: SCSI parity error detected: SCR1=1 DBC=19000000 SSTAT1=1
ncr53c825a-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
