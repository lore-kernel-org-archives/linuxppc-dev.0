Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 0959E67BB4
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 04:53:35 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id m3so1075110uge
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 09:53:31 -0800 (PST)
Message-ID: <528646bc0611270953p3f1aa3adx3dd2261b5f0b307b@mail.gmail.com>
Date: Mon, 27 Nov 2006 10:53:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: jcrigby@gmail.com
Subject: Re: [RFC] Draft mpc52xx device tree specification
In-Reply-To: <4b73d43f0611131741v59f1f780i827f4e95000decdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0611130047v107e7171h804c674534ef8058@mail.gmail.com>
	<20061113135609.601647b0.kim.phillips@freescale.com>
	<4b73d43f0611131741v59f1f780i827f4e95000decdf@mail.gmail.com>
Cc: jrigby@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/13/06, John Rigby <jrigby@freescale.com> wrote:
> I agree with Kim.  I would like to see some kind of merge of this an
> booting-without-of.

okay, I understand the point, and I agree.  However I've also received
the comment that this document also needs to address boards with real
OFW, and that booting_without_of.txt is kind of limited in that regard

Perhaps it would be better to split off a 'device tree binding
conventions' document; use booting_without_of.txt to describe the
mechanism for non-OFW ports, and use another doc to describe layout
expectation/conventions for common SoC's and devices.

I'm about to post a patch set for the 52xx boards which includes this
document.  For the time being, I'm going to leave the document as is
because I haven't had a chance to do any revision, but I'll take a
look at shuffling stuff around once the 52xx patches are suitable for
inclusion in .20

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
