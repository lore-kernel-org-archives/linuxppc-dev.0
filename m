Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id DD54EDDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 05:32:43 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1028042ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 12:32:42 -0700 (PDT)
Message-ID: <528646bc0705141232x184cf89aw1d2c2d4833055a30@mail.gmail.com>
Date: Mon, 14 May 2007 13:32:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Brownell" <david-b@pacbell.net>, rtc-linux@googlegroups.com,
	linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	"James Chapman" <jchapman@katalix.com>, "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
In-Reply-To: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/14/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> Work still to be done (in another patch): support for pulling i2c client
> registrations out of the device tree.

I had also fogotten about Scott Woods patches from last Nov. which
take care of this.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
