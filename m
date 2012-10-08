Return-Path: <michael@ellerman.id.au>
Message-ID: <1349740469.32656.2.camel@concordia>
Subject: Re: [PATCH 0/5] Move some OF functionality from pseries to generic
 OF code
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 09 Oct 2012 10:54:29 +1100
In-Reply-To: <506B2E63.5090900@linux.vnet.ibm.com>
References: <506B2E63.5090900@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-02 at 13:11 -0500, Nathan Fontenot wrote:
> This set of patches moves some OF code that has been living
> in the pseries tree over to the generic OF code base. The
> functionality being migrated over is something that, I believe,
> should live in the generic code base. The specific functionality
> being migrated to generic OF code is;

Your changes collide with commit 475d0094293:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=475d0094293b51353e342d1198377967dbc48169


At a quick glance they don't look like they conflict in concept, just
textually.

cheers
