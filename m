Return-Path: <mnazarewicz@gmail.com>
Sender: =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mnazarewicz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: "Alexandre Pereira da Silva" <aletes.xgr@gmail.com>, "Rob Herring"
 <robherring2@gmail.com>
Subject: Re: [PATCH 5/5] usb: gadget: composite: parse dt overrides
References: <1340720833-781-1-git-send-email-aletes.xgr@gmail.com>
 <1340720833-781-6-git-send-email-aletes.xgr@gmail.com>
 <4FEA02B7.3030801@gmail.com>
Date: Tue, 26 Jun 2012 21:18:48 +0200
MIME-Version: 1.0
From: "Michal Nazarewicz" <mina86@mina86.com>
Message-ID: <op.wgiylmt83l0zgt@mpn-glaptop>
In-Reply-To: <4FEA02B7.3030801@gmail.com>
Cc: Roland Stigge <stigge@antcom.de>, linux-doc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
 Rob Landley <rob@landley.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On 06/26/2012 09:27 AM, Alexandre Pereira da Silva wrote:
>> Grab the devicetree node properties to override VendorId, ProductId,
>> bcdDevice, Manucacturer, Product and SerialNumber

Like before, the code looks good to me:

Acked-by: Michal Nazarewicz <mina86@mina86.com>

Not commenting on the other aspects of the business logic though.

On Tue, 26 Jun 2012 20:43:03 +0200, Rob Herring <robherring2@gmail.com> =
wrote:
> I'm still confused about what is the order of priority for the 2
> possible sources of these values. The way it is written, the DT value =
is
> a default, not an override.

They are overwritten by module parameter but they are overwriting anythi=
ng that
composite gadget might be providing.

-- =

Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz=
    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
