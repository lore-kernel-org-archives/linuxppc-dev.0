Return-Path: <robherring2@gmail.com>
MIME-Version: 1.0
In-Reply-To: <517995D0.8020307@gmail.com>
References: <1366596798-9457-1-git-send-email-robherring2@gmail.com>
 <1366596798-9457-2-git-send-email-robherring2@gmail.com>
 <CAL_JsqKDF=hPEM0Jz-zZSXBCXBZ=gBjLWL6QDvq+nFWkqY3DMw@mail.gmail.com>
 <1366911329.2869.31.camel@pasglop> <517980B0.3000401@gmail.com>
 <1366920741.2869.32.camel@pasglop> <517995D0.8020307@gmail.com>
Date: Wed, 22 May 2013 07:26:42 -0500
Message-ID: <CAL_JsqKXt-gFL4y_k-_dFktpk1JD_S2G+hUsoOavw8QugFMOKA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ibmebus: convert of_platform_driver to platform_driver
From: Rob Herring <robherring2@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Roland Dreier <roland@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Raisch <raisch@de.ibm.com>, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@linaro.org>, Paul Mackerras <paulus@samba.org>,
 Sean Hefty <sean.hefty@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Hal Rosenstock <hal.rosenstock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 3:45 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 04/25/2013 03:12 PM, Benjamin Herrenschmidt wrote:
>> On Thu, 2013-04-25 at 14:14 -0500, Rob Herring wrote:
>>> On 04/25/2013 12:35 PM, Benjamin Herrenschmidt wrote:
>
> [...]
>
>>> You need patch 2 of this series to fix this:
>>>
>>> driver core: move to_platform_driver to platform_device.h
>>>
>>> which as Arnd pointed out needs to come first. I've fixed that in my
>>> tree, but I don't think it warrants another post.
>>
>> Can I pull you tree from somewhere to test ?
>
> Here you go:
>
> git://sources.calxeda.com/kernel/linux.git of-platform-removal

Ben,

Did you have a chance to test this? I want to get this into -next.

Rob
