Message-Id: <5.1.0.14.2.20030603114931.034e0ea8@falcon.si.com>
Date: Tue, 3 Jun 2003 11:50:37 -0400
To: Flavio.Pereira@za.flextronics.com, wd@denx.de
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: RE: System crash in kernel_thread
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <00047904.C22236@za.flextronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What initialization is your BDI doing?  How does it compare to the actual
initialization that works?  Answering those two questions should be
enlightening.

gvb


At 05:16 PM 6/3/2003 -0400, Flavio.Pereira@za.flextronics.com wrote:

>Hi Wolfgang
>
> >It is most likely that the RAM errors happen when you use  bust  mode
> >accesses - which happens a lot when Linux starts working.
> >guess you know that there are already pretty extensive memory tests
> >available in U-Boot (see the post/ code).
> >The problem is, all these tests will not exercise burts mode accesses
> >the same way as Linux will do it, especially when Linux starts moving
> >lot's of data over the network (DMA).
>
>Weird, I was trying to boot with the BDI connected, i.e. issuing a go
>from the BDI> as there was a problem with the HRCW. Now we've fixed that
>(HRCW) and if I do a power reset boot without the BDI, the problem went
>away. It is still there with a BDI start. Well thanks for the help; we
>have the kernel up and running now.
>
>Regards
>Flavio Pereira
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
