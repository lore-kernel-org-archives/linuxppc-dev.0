Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id DAAC0DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 08:52:01 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so942604nzf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 02 Jul 2007 15:52:00 -0700 (PDT)
Message-ID: <fa686aa40707021551y469e1b7fv3b8c329b904b3d6@mail.gmail.com>
Date: Mon, 2 Jul 2007 16:51:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: khollan <khollan@daktronics.com>
Subject: Re: Porting Linux to Xilinx ML410
In-Reply-To: <11401755.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11328063.post@talk.nabble.com> <11401755.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/2/07, khollan <khollan@daktronics.com> wrote:
>
> Im trying to mount the root file system off of compact flash and now I get
> this happening during boot
>
> xsysace xsa: kicking stalled fsm; state=2 task=0 iter=1 dc=0
> xsysace xsa: kicking stalled fsm; state=2 task=0 iter=1 dc=0
> xsysace xsa: kicking stalled fsm; state=2 task=0 iter=1 dc=0
>
> any ideas what this is and how to fix it?  I tried applying a patch that
> talked about this but my version of xsysace.c already had those changes.

It means the driver is not getting interrupts from the systemace
device, so it's reverting to (extremely slow) polling.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
