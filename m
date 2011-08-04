Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E39CA6C.3000202@infradead.org>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<4E39CA6C.3000202@infradead.org>
Date: Thu, 4 Aug 2011 18:31:57 +0200
Message-ID: <CAHsu+b_cwoKNtovjLbDwf3OQssD6Dp-2EARdRJxO23PQguyQJA@mail.gmail.com>
Subject: Re: [PATCH 00/15] ps3: Support more than the OtherOS lpar
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Geoff,

On Thu, Aug 4, 2011 at 12:23 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Andre,
>
> On 08/01/2011 01:02 PM, Andre Heider wrote:
>> This series addresses various issues and extends support when running
>> in lpars like GameOS. Included are some patches from Hector Martin, whic=
h
>> I found useful.
>
> Much of this is just general fixups and improvements to the existing PS3
> support. =A0I think you should separate those changes out and work to get
> them included, then consider others. =A0If I give some comment, then
> I consider that part worth pursuing at the present time.

Sounds like a good approach to me.

> I have limited time to review the patches, so it will take me a while to
> get through them.

No problem at all, it will probably take some time to resolve all the
details anyway.

>> Patches are based on 2.6.39 since master doesn't boot with smp on my
>> console. =A0I wasn't able to pinpoint the cause so far (not that I tried
>> too hard).
>
> I'm looking into this problem, but it will take some time.

Just for the record: I didn't mean to push ;)

Thanks,
Andre
