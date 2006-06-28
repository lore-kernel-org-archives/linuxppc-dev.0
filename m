Return-Path: <mbligh@google.com>
Message-ID: <44A2DA40.40502@google.com>
Date: Wed, 28 Jun 2006 12:36:32 -0700
From: Martin Bligh <mbligh@google.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org>	<20060628034748.018eecac.akpm@osdl.org>	<44A29582.7050403@google.com>
	<20060628121102.638f08d9.akpm@osdl.org>
In-Reply-To: <20060628121102.638f08d9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jeremy@goop.org, drfickle@us.ibm.com, linux-kernel@vger.kernel.org,
	mbligh@mbligh.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>How the hell did you figure that one out?
> 
> Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
> tight loop.  With that happening, a little two-way wasn't able to make
> it through `dbench 4' without soiling the upholstery.  Then bisection-searching.

Aha. we probably trigger it because the automated test harness dumps a
bunch of crap out of /proc before and after running dbench then ;-)

Thanks!

M.
