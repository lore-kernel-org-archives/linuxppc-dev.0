Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.224])
	by ozlabs.org (Postfix) with ESMTP id C79A3DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:40:02 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1088775wxd
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 07:39:58 -0800 (PST)
Message-ID: <fa686aa40711220739i3e950a59w5becd19125c23ff1@mail.gmail.com>
Date: Thu, 22 Nov 2007 08:39:58 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: Xilinx Linux git server available
In-Reply-To: <871waifgbf.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071114015615.12B9B1528050@mail173-sin.bigfish.com>
	<8763zufl29.fsf@macbook.be.48ers.dk>
	<fa686aa40711220635g1aa7dcc9w823de6a8c2d5832a@mail.gmail.com>
	<871waifgbf.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/22/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
>  >> Why another uartlite driver? What's wrong with mine in mainline?
>
>  Grant> Relax; he's talking about your driver.
>
> Ok, I had a quick look at the tree and saw a uartlite-alternative.c -
> What's that about?

What directory is that in?  I had looked in drivers/serial and only
saw uartlite.c:

http://git.xilinx.com/cgi-bin/gitweb.cgi?p=linux-2.6-xlnx.git;a=tree;f=drivers/serial;h=c8732c1f044a73cf58fa457ee106d4b042da8308;hb=4f231e89006726aea321c7d710045d37e904914e

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
