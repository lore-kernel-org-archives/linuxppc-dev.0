Message-ID: <4047425D.1080602@imc-berlin.de>
Date: Thu, 04 Mar 2004 15:51:09 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uncached user space mapping with mmap() ???
References: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFC7@renexch3.rennes.thmulti.com>
In-Reply-To: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFC7@renexch3.rennes.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Fillod Stephane wrote:

>>And: Can I mmap() 32MB of peripheral memory into user space?
>
> I don't see any reason why you would not be able to.
Don't know. Maybe the number of entries in the translation tables are
limited...

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
