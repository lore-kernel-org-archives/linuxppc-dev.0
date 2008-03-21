Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.245])
	by ozlabs.org (Postfix) with ESMTP id 502EBDE41E
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 06:02:08 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1502127hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 12:02:07 -0700 (PDT)
Message-ID: <fa686aa40803211202g5f87f40et61e340c217482bc6@mail.gmail.com>
Date: Fri, 21 Mar 2008 13:02:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: Oops with TQM5200 on TQM5200
In-Reply-To: <47E3561B.6040505@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com> <47E3561B.6040505@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2008 at 12:30 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Bartlomiej Sieka wrote:
>  > Grant Likely wrote:
>  >> Paul, my git server is down at the moment.  Can you please pick this
>  >> one up for .25?  It is needed to boot the tqm5200 board.
>  >
>  > Could we also have similar fixes for cm5200.dts and motionpro.dts picked
>  > up? I could provide the patches within a day -- will this be OK?
>
>  At that occasion, could you please also add two CAN nodes to tqm5200.dts
>  as shown:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
>  s$ diff -u tqm5200.dts tqm5200.dts.CAN
>  --- tqm5200.dts 2008-03-20 18:44:40.000000000 +0100
>  +++ tqm5200.dts.CAN     2008-03-21 07:27:49.000000000 +0100
>  @@ -68,6 +68,22 @@
>                         fsl,has-wdt;
>                 };
>
>  +               can@900 {
>  +                       compatible = "fsl,mpc5200-mscan";
>  +                       cell-index = <0>;
>  +                       interrupts = <2 11 0>;
>  +                       interrupt-parent = <&mpc5200_pic>;
>  +                       reg = <900 80>;
>  +               };
>  +
>  +               can@980 {
>  +                       compatible = "fsl,mpc5200-mscan";
>  +                       cell-index = <1>;
>  +                       interrupts = <2 12 0>;
>  +                       interrupt-parent = <&mpc5200_pic>;
>  +                       reg = <980 80>;
>  +               };
>  +
>                 gpio@b00 {
>                         compatible = "fsl,mpc5200-gpio";
>                         reg = <b00 40>;
>
-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
