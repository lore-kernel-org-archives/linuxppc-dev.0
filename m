Return-Path: <timur@tabi.org>
Message-ID: <516E1763.7040206@tabi.org>
Date: Tue, 16 Apr 2013 22:30:43 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Tang Yuantian-B29983 <B29983@freescale.com>
Subject: Re: [PATCH v2] of/base: release the node correctly in
 of_parse_phandle_with_args()
References: <1365564999-24427-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAOZdJXW8qKccGKic3R4o1aqJdbfHcBoAp62B4HPFnF=sUAEvuQ@mail.gmail.com>
 <D07C73A334FF604B95B3CBD2A545D07B0B1456B8@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B1456B8@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Tang Yuantian-B29983 wrote:
>> >On Tue, Apr 9, 2013 at 10:36 PM,<Yuantian.Tang@freescale.com>  wrote:
>>> > >
>>> > >+                       /* Found it! return success */
>> >
>> >I'm pretty sure this comment is in the wrong place.

> It is not perfect, but acceptable.

Like I said, I'm pretty sure it's in the wrong place.

-- 
Timur Tabi
