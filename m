Return-Path: <jwboyer@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1333956052-25319-2-git-send-email-tinamdar@apm.com>
References: <1333956052-25319-1-git-send-email-tinamdar@apm.com>
 <1333956052-25319-2-git-send-email-tinamdar@apm.com>
Date: Wed, 2 May 2012 09:41:37 -0400
Message-ID: <CA+5PVA4HGVGRbnLCMOAbO1mYnFCgHhh1_ErLdKq5YhMdV0VhQw@mail.gmail.com>
Subject: Re: [V2 2/5] powerpc: 40x: Add AHB, APB of_device_ids
From: Josh Boyer <jwboyer@gmail.com>
To: Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 9, 2012 at 3:20 AM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> Adding of_device_id's for AHB and APB buses used in klondike (APM8018X) in
> platforms/40x/ppc40x_simple.c file
>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>

You should probably combine the first 3 patches in this series into one
patch.  Otherwise you run the risk of changing the DTS to something the
kernel can't support.  At the least, this change should be patch 1 in
the series, and you can probably combine the two DTS changes.

josh
