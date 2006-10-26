Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 077636826A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 06:36:29 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so428177ugc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 13:36:28 -0700 (PDT)
Message-ID: <528646bc0610261336i61521af3y3a5f134bb8c2f8da@mail.gmail.com>
Date: Thu, 26 Oct 2006 14:36:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "John Rigby" <jcrigby@gmail.com>
Subject: Re: status of mpc52xx with arch=powerpc?
In-Reply-To: <4b73d43f0610261307sd0668d1x6e535880a46e71d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
	<1161740815.22582.1.camel@localhost.localdomain>
	<528646bc0610242325m45fa610egb47f118f5f4f6f5e@mail.gmail.com>
	<4b73d43f0610261307sd0668d1x6e535880a46e71d3@mail.gmail.com>
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

On 10/26/06, John Rigby <jcrigby@gmail.com> wrote:
> Does Bestcomm dma belong in here somewhere?

I don't think so for embedded targets; but I may be wrong.  Of course;
I think the kernel should be responsible for setting up the bestcomm
tasks.  If a spec is defined for how firmware could preload bestcomm
tasks, then maybe.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
