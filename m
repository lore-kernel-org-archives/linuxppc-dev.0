Return-Path: <geoff@infradead.org>
Message-ID: <4E39CC79.3050208@infradead.org>
Date: Wed, 3 Aug 2011 15:32:25 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 03/15] [PS3] Add region 1 memory early
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-4-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-4-git-send-email-a.heider@gmail.com>
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

On 08/01/2011 01:02 PM, Andre Heider wrote:
> From: Hector Martin <hector@marcansoft.com>

We need an explanation of this change.

> Signed-off-by: Hector Martin <hector@marcansoft.com>
> [a.heider: Various cleanups to make checkpatch.pl happy]
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/mm.c |   62 +++++++--------------------------------
>  1 files changed, 11 insertions(+), 51 deletions(-)
