Message-Id: <v04003a1bb6e0fcadea71@[24.70.162.12]>
In-Reply-To: <Pine.LNX.4.05.10103230815010.930-100000@callisto.of.borg>
References: <v04003a18b6e035380f3f@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 23 Mar 2001 07:22:56 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: st corruption
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:20 AM -0600 3/23/2001, Geert Uytterhoeven wrote:
>On Thu, 22 Mar 2001, Tony Mantler wrote:
>> At 1:41 PM -0600 3/22/2001, Geert Uytterhoeven wrote:
>> [...]
>> >Just create some large files, make md5sums, tar them to tape,
>> >untar them from tape, and verify the md5sums. I see approx. 7 blocks of
>> >corrupted data for 256 MB of data.
>>
>> merida:/home/nicoya# modprobe mesh
>> merida:/home/nicoya# cat /proc/scsi/scsi
>> Attached devices:
>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>   Vendor: QUANTUM  Model: FIREBALL ST4300S Rev: 0F0D
>>   Type:   Direct-Access                    ANSI SCSI revision: 02
>> Host: scsi0 Channel: 00 Id: 03 Lun: 00
>>   Vendor: MATSHITA Model: CD-ROM CR-8012   Rev: 1.0f
>>   Type:   CD-ROM                           ANSI SCSI revision: 02
>> Host: scsi0 Channel: 00 Id: 06 Lun: 00
>>   Vendor: ARCHIVE  Model: Python 25501-XXX Rev: 2.96
>>   Type:   Sequential-Access                ANSI SCSI revision: 02
>
>Ugh... I don't dare to connect my DDS to the MESH. Before I had the '875,
>I did
>it, but from time to time I got lost arbitrations corrupting data.

Well, the tape drive itself is actually the assembled parts of 2 broken
tape drives, so I wouldn't exactly trust it with my life anyways. ;)

It's really just sitting in my 9600 because I didn't have anywhere else
interesting to stick it.


>> 118c94df7aae2df0fb26dce3b13312f9  testfile
>> merida:/home/nicoya# uname -a
>> Linux merida 2.4.1 #1 SMP Mon Feb 5 17:32:52 CST 2001 ppc unknown
>
>Hmmm... Perhaps I should retry on the MESH, just to see whether it's a MESH or
>Sym53c875 problem.

Finding someone with Sym53c875 SCSI in a non-pmac non-x86 might help too.

It could also be that my SMP machine has a different cache flushing
profile, since both tar and the st driver would've likely been bouncing
from CPU to CPU a bit. (Am I the only one who would like to see stronger
CPU binding in SMP linux? Especially on platforms with larger caches)


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
