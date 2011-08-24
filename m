Return-Path: <geoff@infradead.org>
Message-ID: <4E545ED8.7030907@infradead.org>
Date: Tue, 23 Aug 2011 19:15:52 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [Cbe-oss-dev] [PATCH part1 v2 4/9] Add region 1 memory early
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>	<1313091073-4572-1-git-send-email-a.heider@gmail.com>	<1313091073-4572-5-git-send-email-a.heider@gmail.com>	<4E54135A.7030509@infradead.org>
	<20110824003720.bc0589b8776467cc42e5d066@studenti.unina.it>
In-Reply-To: <20110824003720.bc0589b8776467cc42e5d066@studenti.unina.it>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Antonio,

On 08/23/2011 03:37 PM, Antonio Ospite wrote:
> Geoff Levand <geoff@infradead.org> wrote:
>> > +	if (!map.r1.size) {
>> > +		DBG("%s:%d: no region 1, not adding memory\n",
>> > +			__func__, __LINE__);
>> > +	} else {
>> 
>> Remove brackets around a single line conditional.
>> 
>> > +		DBG("%s:%d: adding memory: start %llxh, size %llxh\n",
>> > +			__func__, __LINE__, map.rm.size, map.r1.size);
>> > +
>> > +		memblock_add(map.rm.size, map.r1.size);
>> > +		memblock_analyze();
>> > +	}
>> > +
> 
> In Documentation/CodingStyle I read that if [only] one branch is a
> single statement then the parenthesis are OK (and even recommended) for
> both branches, I guess this is for style consistency. See Chapter 3,
> around line 169 on my copy. I guess the wording on that paragraph can
> be made more explicit, I'll try to fix that up.

Thanks for the comments.  I don't think its such an important change,
mainly for consistency of style within the PS3 files.

-Geoff
