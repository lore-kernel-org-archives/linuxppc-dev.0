Return-Path: <jonsmirl@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.230])
	by ozlabs.org (Postfix) with ESMTP id 2DA8EDDDF9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 05:02:26 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so978101qbe
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 10:02:24 -0800 (PST)
Message-ID: <9e4733910711071002h64ea7947w154c8fd81c1d4559@mail.gmail.com>
Date: Wed, 7 Nov 2007 13:02:23 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	Tjernlund <tjernlund@tjernlund.se>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Modifying i2c-core to support alias driver names compatible
	with device trees
In-Reply-To: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/6/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> This code modifies the i2c-core to support lists of alias names in the
> chip drivers.

Any comments on this code?

-- 
Jon Smirl
jonsmirl@gmail.com
