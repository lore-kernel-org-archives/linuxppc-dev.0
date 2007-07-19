Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40707191300v48ea7ebbj47b883563f11c9df@mail.gmail.com>
Date: Thu, 19 Jul 2007 14:00:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jerry Van Baren" <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
In-Reply-To: <469FC275.7050309@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070719183415.7458.42622.stgit@trillian>
	<20070719183734.7458.83695.stgit@trillian>
	<469FB47D.4030009@freescale.com>
	<fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>
	<469FC275.7050309@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/19/07, Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com> wrote:
> I think the "proper" solution is not to add the /chosen node in the dts
> but rather to generate a _correct_ one in u-boot.  Note that
> linux,stdout-path is something that _should_ be generated based on the
> u-boot configuration (currently it is hard #defined, IMHO it should be
> part of the u-boot environment).

That works for u-boot; but it doesn't work for cuImage.  As it stands
now; you need different dts files for the two boot methods.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
