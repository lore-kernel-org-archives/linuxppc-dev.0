Return-Path: <benh@kernel.crashing.org>
Message-ID: <1428438122.4947.6.camel@kernel.crashing.org>
Subject: Re: [Skiboot] [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Date: Wed, 08 Apr 2015 06:22:02 +1000
In-Reply-To: <55241C02.60103@fr.ibm.com>
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
 <20150407164439.GA4514@roeck-us.net> <55241C02.60103@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>,
 lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 20:03 +0200, Cedric Le Goater wrote:
> 
> This is a shortcut. The code is for the ibmpowernv platform and assumes 
> that we are running on a P8 (8 hardware threads). It would be better to 
> use a "maximum threads per core" variable but I am not sure this is 
> available, as it is a tunable. I will look into it.

Yes, please don't hard code this...

Cheers,
Ben.
