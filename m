Message-ID: <6F8DFFA2C996D711945800065BFC9E4A03B991CF@il02exm11>
From: Silverton Aron-C1710C <Aron.J.Silverton@motorola.com>
To: "'Ashwin Bihari'" <raz0redge@hotmail.com>,
	"'beena@gdatech.com'" <beena@gdatech.com>,
	"'dank@kegel.com'" <dank@kegel.com>
Cc: "'listmember@orkun.us'" <listmember@orkun.us>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Cross-compile package combinations
Date: Tue, 16 Dec 2003 13:14:24 -0600
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ashwin Bihari <mailto:raz0redge@hotmail.com> wrote:
>> I do have a another question, though.  Let's say that I want to
>> use my own kernel instead of having crosstool download it.  What
>> would be the proper set of steps to take to specify a local
>> kernel?  My current kernel is
>> 2.4.20 and I know that the combination of gcc and glibc that I
>> want to use with crosstool specifies 2.4.21.  I'll probably work
>> on bumping my kernel up.
>>
>> Aron
>
> The way I did this was to use crosstool to just create the
> cross-compiler for me. From there I took it upon myself to
> install it in the appropriate directory and then compile the
> kernel I wanted. That proved to be easy enough for me.
>
> ~Ashwin
>

Ashwin

I was referring to the kernel headers used to build the tools as opposed to the building of the actual kernel.  I'll have to look through the crosstool scripts, but I'd guess that if the file already exists, it won't download it.  I'll probably bump up the version on my kernel to match what crosstool wants to see and then put it in the location that I specified in my crosstool configuration.

Thanks,

Aron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
