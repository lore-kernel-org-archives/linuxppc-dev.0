Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710191209u883b3d0r954e7b3d6d1b8d12@mail.gmail.com>
Date: Fri, 19 Oct 2007 13:09:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: embedded a default dtb in the kernel (was merge dtc)
In-Reply-To: <556445368AFA1C438794ABDA8901891C075945FD@USA0300MS03.na.xerox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <556445368AFA1C438794ABDA8901891C075945FD@USA0300MS03.na.xerox.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/19/07, Leisner, Martin <Martin.Leisner@xerox.com> wrote:
> Is there a way to embed a default dtb into the kernel?
> When I build a kernel, I want to embed a dtb into it --
> so I don't have to deal with the headaches of finding the
> right file to match the right board (its always easier to
> deal with 1 file than 2).
>
> If there is, it makes sense to put dtc into the tree.
> If there's not, there should be a way to embed dtb's; and put
> dtc and dts's into the tree.
> If there can't be (I haven't examined this but relaying my
> experiences), then it should be in a separate repository
> (but the DTS and DTC should be in one place).
> It was a little difficult to cobble together a working
> system the first time.
>
> Also, mkimage SHOULD definitely go in the tree.  Its necessary
> to build, hence should be in the tree...

Why?  mkimage is u-boot specific, and hence is maintained by u-boot.
If you're not using u-boot, then you don't need mkimage.  What is
wrong with it being a prereq like all the other tools we use?  If
you're doing embedded development, you're installing non-distribution
cross toolchain anyway.

dtc and mkimage are embedded development tools.  They belong with the
embedded development toolchain.  mkimage is already part of ELDK.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
