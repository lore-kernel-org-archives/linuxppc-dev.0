Return-Path: <geoff@infradead.org>
Message-ID: <4E5424CF.70706@infradead.org>
Date: Tue, 23 Aug 2011 15:08:15 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH part1 v2 6/9] ps3: Detect the current lpar
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-7-git-send-email-a.heider@gmail.com>
In-Reply-To: <1313091073-4572-7-git-send-email-a.heider@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 08/11/2011 12:31 PM, Andre Heider wrote:
> Detect it by reading the ss laid repository node, and make it
> accessible via ps3_get_ss_laid().

I'm wondering now if we even need this.  It is mainly used by your
later patch 8/9 that modifies ps3flash_init() to test if we should
call ps3_system_bus_driver_register().  If we don't use
ps3_get_ss_laid() and just allow ps3_system_bus_driver_register()
to be called, would the device probe fail and have the same result
as the test?

I would prefer to not have ps3_get_ss_laid() if possible.

-Geoff
