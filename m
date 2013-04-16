Return-Path: <timur@tabi.org>
MIME-Version: 1.0
In-Reply-To: <1365564999-24427-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1365564999-24427-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Tue, 16 Apr 2013 06:37:21 -0500
Message-ID: <CAOZdJXW8qKccGKic3R4o1aqJdbfHcBoAp62B4HPFnF=sUAEvuQ@mail.gmail.com>
Subject: Re: [PATCH v2] of/base: release the node correctly in
 of_parse_phandle_with_args()
From: Timur Tabi <timur@tabi.org>
To: Yuantian.Tang@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 9, 2013 at 10:36 PM,  <Yuantian.Tang@freescale.com> wrote:
>
> +                       /* Found it! return success */

I'm pretty sure this comment is in the wrong place.
