Message-ID: <3EA7D9D1.4090308@mvista.com>
Date: Thu, 24 Apr 2003 07:34:25 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Rakesh Jagota <j.rakesh@gdatech.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Library size
References: <781he2iuwdfhp6z.240420031340@gda-server>
In-Reply-To: <781he2iuwdfhp6z.240420031340@gda-server>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Search the list archives for Library Optimization.

There a ways to reduce the size of a glibc C library, or you should us an
alternative C library such as uClibc.

--Mark

Rakesh Jagota wrote:
> Hi all,
> I am working on custome design board based on IBM power PC 405. We have seen
> the libraries like :
>
> ld-2.2.3.so
> libcrypt-2.2.3.so
> ld.so.1
> libpthread-0.9.so
> libSegFault.so
> libc-2.2.3.so
>
> in the filesystem, lib folder.
> "libc-2.2.3.so" is taking arounr 1.5MB space. Is there any way to reduce the
> size of this file and whats the use of this file.
>
> Thanks & Regards,
>
> Rakesh Jagota
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
