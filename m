Message-ID: <39AAA09A.1E4D2A6C@raleigh.ibm.com>
Date: Mon, 28 Aug 2000 13:25:46 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Seong-kyu Ko <sugenius@doit.ajou.ac.kr>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems of the corss-compiler.
References: <Pine.LNX.4.21.0008290209060.960-100000@doit.ajou.ac.kr>
Content-Type: multipart/mixed;
 boundary="------------03E6216208BA9FAEA8F22556"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------03E6216208BA9FAEA8F22556
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Seong-kyu Ko,

You might want to let us know what platform you are running on?.

I myself am very partial to the montavista tool chain.  It seems rock
Solid
and they have the bash shell and other stuff already compiled.

Chip

Seong-kyu Ko wrote:
>
> Hi everyone.
> First, I'm sorry for my weak English.
>


> Well, Now I build a powerpc cross-compiler.
> so I compiled some binary using that cross-compiler, but
> I have some problems.
>
> I think cross-compiler is not problem.
> because I compile kernel with that cross-compiler, and
> kernel runs good.
>
> but, init, shell etc thease binaries have some problems.
> shell cant recieve argument, and some binaries print 'segmentation fault'
>
> I don't know why my compiler can't compile well.
>
> These are the packages that I used.
> 1. binutils-2.10
> 2. gcc-2.95.2
> 3. glibc-2.1.3 (add-ons : glibc-crypt-2.1, glibc-linuxthreads-2.1.3)
>
> First, I compile the binutils for powerpc cpu.
> Second, I build cross compiler with gcc.
> Third, I compile glibc for powerpc with cross compiler that I made.
> Last, I re-build cross compiler include glibc for library.
>
> Please tell me what do you think about that And why the problem happen.
> I'll wait your answers.
> thank you.
>
--------------03E6216208BA9FAEA8F22556
Content-Type: text/x-vcard; charset=us-ascii;
 name="rcblach.vcf"
Content-Description: Card for Ralph Blach
Content-Disposition: attachment;
 filename="rcblach.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
n:Blach;Ralph
tel;work:919-543-1207
x-mozilla-html:TRUE
url:www.ibm.com
org:IBM MicroElectronics
adr:;;3039 Cornwallis		;RTP;NC;27709;USA
version:2.1
email;internet:rcblach@raleigh.ibm.com
x-mozilla-cpt:;24544
fn:Ralph Blach
end:vcard

--------------03E6216208BA9FAEA8F22556--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
