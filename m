Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 20E9FDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 02:06:22 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so461027ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 07:06:20 -0800 (PST)
Message-ID: <528646bc0701190706l752835a1ta17814ce4ff78794@mail.gmail.com>
Date: Fri, 19 Jan 2007 08:06:19 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Bruce_Leonard@selinc.com" <Bruce_Leonard@selinc.com>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
In-Reply-To: <OFFF3222ED.48527A84-ON88257267.00787606-88257267.007A6E89@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070118124031.3d5e0079.kim.phillips@freescale.com>
	<OFFF3222ED.48527A84-ON88257267.00787606-88257267.007A6E89@selinc.com>
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

On 1/18/07, Bruce_Leonard@selinc.com <Bruce_Leonard@selinc.com> wrote:
> Kim Phillips <kim.phillips@freescale.com> wrote on 01/18/2007 10:40:31 AM:
>
> > > Per Grant's suggestion I changed it to:
> > > 'dtc -I dts -O dtb -V 0x10 mpc8349emitx.dts > 8349.blob'
> > >
> > I get a 0 length 8349.blob file using the above.  Have you tried -f?
> >
> > Kim
>
> Hummmmm, interesting.  I get a blob of about 4K when I do it.  Oh, ooops.
> Sorry.  I did have to modify the *.dts file to get it to compile.  There
> was an error because there wasn't a 'linux,boot-cpu' entry in the cpu
> node.

BTW, you don't need to add a linux,boot-cpu node to your .dts file.
In fact you don't need anything in the /chosen node at all.  Just pass
the -f flag to your version of dtc.  (This is also something fixed in
the latest dtc code from www.jdl.com)

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
