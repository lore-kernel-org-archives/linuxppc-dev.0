Date: Fri, 23 Mar 2001 08:20:45 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tony Mantler <nicoya@apia.dhs.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: st corruption
In-Reply-To: <v04003a18b6e035380f3f@[24.70.162.12]>
Message-ID: <Pine.LNX.4.05.10103230815010.930-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 22 Mar 2001, Tony Mantler wrote:
> At 1:41 PM -0600 3/22/2001, Geert Uytterhoeven wrote:
> [...]
> >Just create some large files, make md5sums, tar them to tape,
> >untar them from tape, and verify the md5sums. I see approx. 7 blocks of
> >corrupted data for 256 MB of data.
>
> merida:/home/nicoya# modprobe mesh
> merida:/home/nicoya# cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: QUANTUM  Model: FIREBALL ST4300S Rev: 0F0D
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 03 Lun: 00
>   Vendor: MATSHITA Model: CD-ROM CR-8012   Rev: 1.0f
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 06 Lun: 00
>   Vendor: ARCHIVE  Model: Python 25501-XXX Rev: 2.96
>   Type:   Sequential-Access                ANSI SCSI revision: 02

Ugh... I don't dare to connect my DDS to the MESH. Before I had the '875, I did
it, but from time to time I got lost arbitrations corrupting data.

> 118c94df7aae2df0fb26dce3b13312f9  testfile
> merida:/home/nicoya# uname -a
> Linux merida 2.4.1 #1 SMP Mon Feb 5 17:32:52 CST 2001 ppc unknown

Hmmm... Perhaps I should retry on the MESH, just to see whether it's a MESH or
Sym53c875 problem.

Thanks for testing!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
