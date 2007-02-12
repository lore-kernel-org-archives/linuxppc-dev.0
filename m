Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 94C4EDDDEB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:55:09 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1392705ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 13:55:04 -0800 (PST)
Message-ID: <528646bc0702121355k4879737eic63ab285f7213271@mail.gmail.com>
Date: Mon, 12 Feb 2007 14:55:03 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Subject: Re: [RFC] mpc5200 device tree bindings refinement
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3029428D5@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11710062092006-git-send-email-grant.likely@secretlab.ca>
	<9696D7A991D0824DBA8DFAC74A9C5FA3029428D5@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/12/07, Yoder Stuart-B08248 <stuart.yoder@freescale.com> wrote:
> My suggestion would be to _not_ create a brand new property
> called system-frequency.  Could we not use the existing
> clock-frequency property instead (defined to mean the
> Fsystem frequency)?
>
> Currently across many device types (e.g. PCI, serial) the
> clock-frequency property is used to describe the clock
> frequency in a way specific to that device.  Could that work
> here?
>
> If you did need to create a new property unique to this
> particular device it should have the vendor name preprended
> to the property (e.g. linux,phandle).

Now that I think about it some more; Is a vendor name prefix really
warranted here?  I don't see any other examples of vendor prefix being
used for other SoC property values.  (linux,phandle is the notable
exception, but that's not an SoC thing).

I bring up this issue because it seems quite inconsistent.  Most of
the device nodes already uses custom properties w/o any vendor prefix.
 Why make this one the first with a prefix?  :-)

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
