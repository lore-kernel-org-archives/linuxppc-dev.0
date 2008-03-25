Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A05ADDDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 20:54:52 +1100 (EST)
Message-ID: <47E8CBE7.20008@grandegger.com>
Date: Tue, 25 Mar 2008 10:54:47 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Oops with TQM5200 on TQM5200
References: <47E2723D.1090101@grandegger.com>	<47E281B6.20702@denx.de>	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>	<47E2FC3E.1020705@semihalf.com>	<47E3561B.6040505@grandegger.com>
	<18407.20074.364347.911781@cargo.ozlabs.ibm.com>
In-Reply-To: <18407.20074.364347.911781@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Wolfgang Grandegger writes:
>> Bartlomiej Sieka wrote:
>>> Grant Likely wrote:
>>>> Paul, my git server is down at the moment.  Can you please pick this
>>>> one up for .25?  It is needed to boot the tqm5200 board.
>>> Could we also have similar fixes for cm5200.dts and motionpro.dts picked
>>> up? I could provide the patches within a day -- will this be OK?
>> At that occasion, could you please also add two CAN nodes to tqm5200.dts
>> as shown:
> 
> Does this really need to go in for 2.6.25 -- i.e., does it fix a
> regression or a serious bug (not just a missing feature)?  If so,
> please send it with a proper subject and patch description, with your
> Signed-off-by.

It's not a serious bug fix, of course, but the mentioned DTS file needs
fixing anyhow and I asked Bartlomiej to add the two CAN nodes at that
occasion to avoid another round of updates.

Thanks,

Wolfgang.
