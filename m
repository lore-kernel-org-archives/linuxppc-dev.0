Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id B5AB7DDEB7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 07:57:34 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3088568wag
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Dec 2007 12:57:33 -0800 (PST)
Message-ID: <9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
Date: Sun, 9 Dec 2007 15:57:33 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
In-Reply-To: <1197233208.6563.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/9/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sun, 2007-12-09 at 15:24 -0500, Jon Smirl wrote:
> > What is the status of this series, is there anything I can do to help
> > get this into the i2c subsystem?
>
> I think there were a few comments such as whitespace issues and Scott
> had a comment about a tag to differenciate matching type.

Are there technical concerns with this series? The white space can be
fixed in a few minutes.

Adding a tag to differentiate matching types has implications that are
broader than just i2c. Shouldn't we do this first with the existing
scheme and then change the tagging process with later patches?

>
> Thus the expectation is that you'll respin the serie with those
> addressed.
>
> Ben.
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
