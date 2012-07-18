Return-Path: <B07421@freescale.com>
Message-ID: <5006DE87.7020503@freescale.com>
Date: Wed, 18 Jul 2012 11:04:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: require a match on all fields of of_device_id
References: <20120718011151.GA6119@tyr.buserror.net>
 <50062199.7090904@gmail.com>
In-Reply-To: <50062199.7090904@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2012 09:38 PM, Rob Herring wrote:
> On 07/17/2012 08:11 PM, Scott Wood wrote:
>> Commit 107a84e61cdd3406c842a0e4be7efffd3a05dba6 ("of: match by compatible
>> property first") breaks the gianfar ethernet driver found on various
>> Freescale PPC chips.
> 
> You do know this is reverted, right?

No, I didn't.  I got it via Kumar's next branch, and saw that it was
still in your fixes-for-grant branch, and didn't see any revert-related
e-mail activity on the devicetree-discuss list about it.  I now see that
it was reverted directly in Linus's tree (I didn't see either the
original or the revert in Linus's tree when I checked, but apparently I
hadn't fetched that as recently as I thought).

> Here's my fix (untested) which is a bit simpler. I'm assuming if we care
> about which compatible string we are matching to, then we require name
> and type are blank and we only care about compatible strings.

Any particular reason for making that assumption?  We should be avoiding
the need for .name or .type matching in new bindings, but this seems
like unnecessarily inconsistent behavior.

-Scott
