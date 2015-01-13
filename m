Return-Path: <mpe@ellerman.id.au>
Message-ID: <1421118298.26626.2.camel@ellerman.id.au>
Subject: Re: [PATCH 3/6] powerpc/ps3: Write highmem info to repository
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geoff Levand <geoff@infradead.org>
Date: Tue, 13 Jan 2015 14:04:58 +1100
In-Reply-To: <3deced9919246f281e48f1258885937f11a4b4ee.1421109719.git.geoff@infradead.org>
References: <cover.1421109719.git.geoff@infradead.org>
 <3deced9919246f281e48f1258885937f11a4b4ee.1421109719.git.geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Nathan Whitehorn <nwhitehorn@freebsd.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-13 at 01:00 +0000, Geoff Levand wrote:
> Add calls to the ps3_mm_set_repository_highmem() routine when the ps3
> r1 highmem region is either created or destroyed.

What does this actually do? ie. from a user perspective.

cheers
