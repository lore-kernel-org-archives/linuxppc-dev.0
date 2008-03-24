Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18407.20074.364347.911781@cargo.ozlabs.ibm.com>
Date: Mon, 24 Mar 2008 17:47:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Oops with TQM5200 on TQM5200
In-Reply-To: <47E3561B.6040505@grandegger.com>
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com> <47E3561B.6040505@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger writes:
> Bartlomiej Sieka wrote:
> > Grant Likely wrote:
> >> Paul, my git server is down at the moment.  Can you please pick this
> >> one up for .25?  It is needed to boot the tqm5200 board.
> > 
> > Could we also have similar fixes for cm5200.dts and motionpro.dts picked
> > up? I could provide the patches within a day -- will this be OK?
> 
> At that occasion, could you please also add two CAN nodes to tqm5200.dts
> as shown:

Does this really need to go in for 2.6.25 -- i.e., does it fix a
regression or a serious bug (not just a missing feature)?  If so,
please send it with a proper subject and patch description, with your
Signed-off-by.

Paul.
