Message-ID: <393C9EAA.24AF8B28@pop.agri.ch>
Date: Tue, 06 Jun 2000 08:48:11 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2940UW & 2.4.0-test-ac7 PCI probs
References: <200006052039.WAA01344@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michel,

Michel Lanners wrote:
> Get either my PCI patches or Geert's patches posted here a few hours
> ago. Then enable hotswap (still needed, right, Geert?), and the resource
> code should fix any collisions it finds.

Fine, I had to take yours, I wasn't able to apply Geerts one. (Too late/
too tired ???)
I applied the one for 2.3.99p9 to 2.4.0-test1-ac7, success, including
your serial console patch and Takashi's mftb patch for 601 CPU's.
Below the output. I think now I am in the same situation as other
adaptec users on the linux front.
One Q, hotswap == hotswap PCI in 'General Setup'?

Thanks

Andreas

-------

Total memory = 80MB; using 512kB for hash table (at c0300000)
Linux version 2.4.0-test1-ac7 (root@pm7200) (gcc version 2.95.3 19991030
(prerelease/franzo)) #7 Tue Jun 6 00:20:04 CEST 2000
PCI bus 0 controlled by bandit at f2000000
Cache coherency enabled for bandit/PSX at f2000000
[snip]
PCI: Probing PCI hardware (semiautomatic)
Scanning bus 00
Found 00:58 [106b/0001] 000600 00
Found 00:68 [10b7/5900] 000200 00
Found 00:70 [9004/8178] 000100 00
Found 00:78 [10b7/9055] 000200 00
Found 00:80 [106b/0002] 00ff00 00
Fixups for bus 00
Bus scan for 00 returning with max=00
PCI: Fixing device 00:0b.0 (106b:0001)
PCI: Fixing device 00:0d.0 (10b7:5900)
PCI: Setting IRQ 23 on device 00:0d.0.
PCI: Correcting IO address 0 on device 00:0d.0, now f2000480.
PCI: Enabling device 00:0d.0 (0004 -> 0005)
PCI: Fixing device 00:0e.0 (9004:8178)
PCI: Setting IRQ 24 on device 00:0e.0.
PCI: Device 00:0e.0 not available because of resource collisions
PCI: Fixing device 00:0f.0 (10b7:9055)
PCI: Setting IRQ 25 on device 00:0f.0.
PCI: Correcting IO address 0 on device 00:0f.0, now f2000400.
PCI: Enabling device 00:0f.0 (0014 -> 0017)
PCI: Fixing device 00:10.0 (106b:0002)
PCI: Resource f2000480-f200049f (f=101, d=0, p=0)
PCI: Resource 80801000-80801fff (f=200, d=0, p=0)
PCI: Resource f2000400-f200047f (f=101, d=0, p=0)
PCI: Resource 80800000-8080007f (f=200, d=0, p=0)
PCI: Resource f3000000-f301ffff (f=200, d=0, p=0)
  for root[0:ffffffff] min[1000] size[100]
  got res[1000:10ff] for resource 0
[snip]
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/14/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Warning - detected auto-termination
(scsi0) Please verify driver detected settings are correct.
(scsi0) If not, then please properly set the device termination
(scsi0) in the Adaptec SCSI BIOS by hitting CTRL-A when prompted
(scsi0) during machine bootup.
(scsi0) Cables present (Int-50 NO, Int-68 YES, Ext-68 NO)
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.0/3.2.4
       <Adaptec AHA-294X Ultra SCSI host adapter>
scsi1 : 53C94
scsi : 2 hosts.
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
lun 0 Inquiry 00 00 00 ff 00
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
