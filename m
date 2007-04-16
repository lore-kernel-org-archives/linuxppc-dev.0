Return-Path: <glikely@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id B2F17DDEC0
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 15:59:58 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1388725wxd
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Apr 2007 22:59:57 -0700 (PDT)
Message-ID: <528646bc0704152259o337f77ebme999d2d7ad880227@mail.gmail.com>
Date: Sun, 15 Apr 2007 23:59:56 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: linux 2.6 on xilinx ml403
In-Reply-To: <Pine.LNX.4.44.0704101337030.26940-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.44.0704101337030.26940-100000@slslc02.psi.ch>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/10/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> Hi All,
>
>         I am new in the linux powerpc linux. I have the Avnet evaluation
> board which contains xilinx ml403 (Virtex-4 FX family). The challenge I
> have is to build linux (most preferable 2.6) with suitable drivers.
>
> On the net I have found much information how to build linuxppc 2.4 for
> xilinx ml300/ml301. I did not found however any good reference which
> refers to kernel 2.6 and suitable patches for powerpc 405 which is
> included in the ml403.
>
> I would appreciate very much if someone could provide me with some good
> reference links referring kernel 2.6 for PPC 405 on xilinx ml403.
> I have found the place to download the linuxppc_2_4_devel on BitKeper page
> but there is no equivalent like linuxppc_2_6_devel.

The mainline tree has ml403 support, but it's not complete.  I just
posted a set of patches that clean up a bunch of stuff and add some
support.  Also, if you look through the mailing list archive, you can
find a copy of the adapter.c file needed to make the Xilinx TEMAC
driver work with Linux.

I'm also planing to publish my git tree tomorrow where I've integrated
all the patches I need to get Linux in a useful state for the ml403.
The git tree will show up on http://git.secretlab.ca.  You might find
it easier to grab my tree and use that as your starting point.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
