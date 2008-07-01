Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
Date: Tue, 1 Jul 2008 11:12:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V4
In-Reply-To: <20080701170544.72051418@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/1/08, Jean Delvare <khali@linux-fr.org> wrote:
> I'm fine with this patch. In particular, exporting i2c_bus_type is OK.
>  It was un-exported only because it had no user left, but it can be
>  exported again if needed.

Another solution would be to move drivers/of/of_i2c into the i2c
directory and make it part of i2c core on powerpc builds.

>  I'm not the one to push this upstream though, as the patch is
>  essentially an openfirmware patch. That would be something for Jochen
>  Friedrich and Paul Mackerras I guess. Would be nice to have a
>  MAINTAINERS entry for OF...
>
>  --
>
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl@gmail.com
