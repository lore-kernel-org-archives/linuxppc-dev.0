Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091009063635.GD12948@yookeroo.seuss>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043154.16890.18883.stgit@angua>
	<20091009063635.GD12948@yookeroo.seuss>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 9 Oct 2009 01:03:57 -0600
Message-ID: <fa686aa40910090003i4564385cv90ee672fa4471fb5@mail.gmail.com>
Subject: Re: [RFC PATCH 10/12] of: merge of_*_flat_dt*() functions
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu,
	devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 9, 2009 at 12:36 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, Oct 06, 2009 at 10:32:02PM -0600, Grant Likely wrote:
>> Merge common flattened device tree code between Microblaze and PowerPC
>
> And I guess another question is do we want to replace these with a
> libfdt based implementation.

Perhaps.  Let me get things unified and sane first though.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
