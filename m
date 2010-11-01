Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTimp-AFN5T3z9o6X9qM-GQXSU5vinf+Lqu_jUmJj@mail.gmail.com>
References: <1288130833-16421-1-git-send-email-ddaney@caviumnetworks.com>
	<20101101051734.GB17587@angua.secretlab.ca>
	<AANLkTimp-AFN5T3z9o6X9qM-GQXSU5vinf+Lqu_jUmJj@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 1 Nov 2010 11:51:06 -0400
Message-ID: <AANLkTimWO1yJkOPDQ28gv-bPPKADGepeVk03eHq3fdAS@mail.gmail.com>
Subject: Re: [PATCH] OF device tree: Move of_get_mac_address() to a common
	source file.
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 1, 2010 at 11:46 AM, Timur Tabi <timur@freescale.com> wrote:
> On Mon, Nov 1, 2010 at 12:17 AM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
>> Applied, thanks; but made some changes to protect this code because it
>> does not work on little endian (it can be fixed in a separate patch)
>
> I'm confused. =A0How does of_get_mac_address() not work on little-endian?

Hmmm, right.  I got confused here.  It should be just fine on
little-endian.  I'll revert my change.  Thanks.

g.
