Return-Path: <robherring2@gmail.com>
Message-ID: <4FF224D5.5090602@gmail.com>
Date: Mon, 02 Jul 2012 17:46:45 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: balbi@ti.com
Subject: Re: [PATCH 5/5] usb: gadget: composite: parse dt overrides
References: <1340720833-781-1-git-send-email-aletes.xgr@gmail.com>
 <1340720833-781-6-git-send-email-aletes.xgr@gmail.com>
 <20120702073522.GE16670@arwen.pp.htv.fi>
In-Reply-To: <20120702073522.GE16670@arwen.pp.htv.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Roland Stigge <stigge@antcom.de>, linux-doc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>,
 linuxppc-dev@lists.ozlabs.org,
 Alexandre Pereira da Silva <aletes.xgr@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2012 02:35 AM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jun 26, 2012 at 11:27:13AM -0300, Alexandre Pereira da Silva wrote:
>> Grab the devicetree node properties to override VendorId, ProductId,
>> bcdDevice, Manucacturer, Product and SerialNumber
>>
>> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> 
> I need Grant's acked-by to queue this one.
> 

Grant is pretty much offline for the next 2 months, so:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob
