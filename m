To: linuxppc-dev@lists.linuxppc.org
Subject: dmasound - kernel panic
From: Jiri Masik <masik@pc203b.fzu.cz>
Date: 10 Aug 2000 00:02:03 +0200
Message-ID: <4vu2cu9jqc.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm testing the new dmasound_awacs patches snd-2.2.17p15-b1-s2.p.bz2
with the rsync pmac-benh kernel as of today.
Linux version 2.2.17pre15-ben1 (root@pbuk) (gcc version 2.95.2
20000220 (Debian GNU/Linux)) #10 Wed Aug 9 11:36:18 CEST 2000

I have a Pismo powerbook and the chip is reported as follows
DMA sound driver core [Ed 18] [4 buffers of 32k for output]
............................. [4 buffers of 32k for  input]
DMA sound driver core called by PowerMac (AWACS rev 3 [screamer])

PowerMac (AWACS rev 3 [screamer]) DMA sound driver:
  sound.format = 0x20 (signed 16 bit big)(Phys:  signed 16 bit big)
  sound.speed = 44100Hz (phys. 44100Hz)
  sound.stereo = 0x1 (stereo)
  write_sq.block_size = 256 write_sq.max_count = 4 write_sq.max_active = 4
  write_sq.count = 4 write_sq.rear_size = 256
  write_sq.active = 2 write_sq.syncing = 0
  read_sq.block_size = 0 read_sq.max_count = 0 read_sq.max_active = 0
  read_sq.count = 0 read_sq.rear_size = 0
  read_sq.active = 0 read_sq.syncing = 0

The audio playback is working fine for mpg123, both headphones and
internal speakers. I'd like to record sounds from the built-in mic and
I've found that I can crash the kernel by cat /dev/audio. This is the
message I'm getting immediately

kernel access of bad area pc 0 lr c8822220c address 0 tsk 398

I've put the ksyms to http://darbujan.fzu.cz/~masik/ksymoops/
I'm not familiar with the kernel debugging please let me know if the
information is incomplete.
thanks,

	Jiri


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
