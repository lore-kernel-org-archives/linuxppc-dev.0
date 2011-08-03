Return-Path: <geoff@infradead.org>
Message-ID: <4E39CA6C.3000202@infradead.org>
Date: Wed, 3 Aug 2011 15:23:40 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 00/15] ps3: Support more than the OtherOS lpar
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
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

Hi Andre,

On 08/01/2011 01:02 PM, Andre Heider wrote:
> This series addresses various issues and extends support when running
> in lpars like GameOS. Included are some patches from Hector Martin, which
> I found useful.

Much of this is just general fixups and improvements to the existing PS3
support.  I think you should separate those changes out and work to get
them included, then consider others.  If I give some comment, then
I consider that part worth pursuing at the present time.

I have limited time to review the patches, so it will take me a while to
get through them.

> Patches are based on 2.6.39 since master doesn't boot with smp on my
> console.  I wasn't able to pinpoint the cause so far (not that I tried
> too hard).

I'm looking into this problem, but it will take some time.

-Geoff
