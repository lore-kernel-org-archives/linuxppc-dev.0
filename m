Return-Path: <geoff@infradead.org>
Message-ID: <4E3AC184.3010001@infradead.org>
Date: Thu, 4 Aug 2011 08:57:56 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH 03/15] [PS3] Add region 1 memory early
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-4-git-send-email-a.heider@gmail.com>
	<4E39CC79.3050208@infradead.org> <4E39E302.9060702@marcansoft.com>
In-Reply-To: <4E39E302.9060702@marcansoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Hector,

On 08/03/2011 05:08 PM, Hector Martin wrote:
> On 08/04/2011 12:32 AM, Geoff Levand wrote:
>> We need an explanation of this change.

Sorry for such a terse request.  What I meant was that
this is a significant change to how high mem is managed,
so the patch needs a comment explaining the change.

> I actually have a hard time understanding the reason for the existing
> behavior of hot-adding memory halfway through the boot process. Maybe
> you can shed some light on this?

LV1 was intended to be a generic hypervisor for the Cell
processor.  It was imagined that it could be used on machines
which could be running many lpars.  Around the same time I
was doing the high mem support the hot plug memory support was
being developed.  I thought at some point there would be
hot-unplug, which could be used to move memory between lpars.

At the present time this change make sense, since it is simpler
and more flexible.

-Geoff
