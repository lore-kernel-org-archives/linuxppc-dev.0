Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id B2C7CDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Sep 2007 14:28:12 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so766998rvf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 21:28:12 -0700 (PDT)
Message-ID: <9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
Date: Sat, 15 Sep 2007 00:28:11 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen.puncer@telargo.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Domen's MPC5200 FEC cleanup patch.
In-Reply-To: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/14/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> This patch doesn't seem to working quite right on my hardware (Phytec
> pcm030). At boot I get a long pause.

It also doesn't compile if  CONFIG_FEC_MPC52xx_MDIO is undefined.

-- 
Jon Smirl
jonsmirl@gmail.com
