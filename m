Message-ID: <3E16A271.CE1078E8@koffie.nl>
Date: Sat, 04 Jan 2003 09:59:29 +0100
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: "Suresha H.M" <hm_suresha@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Info needed
References: <20030103053115.12565.qmail@web13409.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Suresha H.M" wrote:
>
> Hello,
>
> Can any body know about how to convert bin to assembly
> in linux? Similar to 'binToAsm' tool of VxWorks.

I usually use

objdump -bbinary -mpowerpc:7400 -EB -z -D some_file

or something like that.  If you do this often, make a shell
script or a shell function or a shell alias to do this...


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
