Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVq+WSjZKVZk1riEFX6NgW6Y+8EhCc0MqMtuDK5KAD7dw@mail.gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-10-git-send-email-a.heider@gmail.com>
	<CAMuHMdVq+WSjZKVZk1riEFX6NgW6Y+8EhCc0MqMtuDK5KAD7dw@mail.gmail.com>
Date: Mon, 1 Aug 2011 22:58:29 +0200
Message-ID: <CAHsu+b_zsBeK1JcNA2XsB+Hh9+eYxAkuMU_4hWZ-Q5zEs_Vcug@mail.gmail.com>
Subject: Re: [Cbe-oss-dev] [PATCH 09/15] ps3: Limit the number of regions per
	storage device
From: Andre Heider <a.heider@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Hector Martin <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 1, 2011 at 10:30 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Aug 1, 2011 at 22:03, Andre Heider <a.heider@gmail.com> wrote:
>> There can be only 8 regions, add a sanity check
>
> Why can there be only 8 regions?

I believe lv1 limits it to 8? I might be mistaken here, it mostly is a
check for the patches after this one
