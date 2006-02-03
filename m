Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id DFFAE689AE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 22:40:23 +1100 (EST)
Message-ID: <1138972275.43e356730f889@webmail.televes.com:443>
Date: Fri,  3 Feb 2006 14:11:15 +0100
From: Alexandre BASTOS <alebas@televes.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM2 USB driver & MPC8248
References: <200602031210.12603.laurent.pinchart@tbox.biz>
	<200602031234.58813.laurent.pinchart@tbox.biz>
In-Reply-To: <200602031234.58813.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

I don't know if it could be of interest for you.
I experienced same problem, but only with a subset of the USB storage
devices I have tested. There are same which worked fine.

Best regards,

Alex

> Hi,
>
> after more testing, I found out that only the first 3 control URBs complete
> successfully. I tried to duplicate the first GET_DESCRIPTOR(CONFIG) request,
> and the second one which worked before now fails. If I unplug/replug the
> device, the first GET_DESCRIPTOR(DEVICE) request sent to device 0 from
> hub_port_init fails:
>
> c0450260 133702068 S Ci:000:00 s 80 06 0100 0000 0040 64 <
> c0450260 134700018 C Ci:000:00 -104 0
> c0450260 134700053 S Ci:000:00 s 80 06 0100 0000 0040 64 <
> c0450260 135700016 C Ci:000:00 -104 0
> c0450260 135700049 S Ci:000:00 s 80 06 0100 0000 0040 64 <
> c0450260 136700018 C Ci:000:00 -104 0
>
> Hope this helps to diagnose the problem,
>
> Laurent Pinchart
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
