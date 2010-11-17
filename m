Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTimTks01SnjWJZFycSCQC+ZBEonPLLUwMRQkxLz2@mail.gmail.com>
References: <20101116204917.12146.39851.stgit@riker>
	<20101116204951.12146.21084.stgit@riker>
	<AANLkTimTks01SnjWJZFycSCQC+ZBEonPLLUwMRQkxLz2@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Nov 2010 22:59:55 -0700
Message-ID: <AANLkTinZ0yi-ZdwjG-KNcjXBuBzNMxrsFRJq4NZOiwk=@mail.gmail.com>
Subject: Re: [PATCH 1/5] scripts: dtc: Merge in changes from the dtc repository
To: Kyle Moffett <kyle@moffetthome.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jdl@jdl.com, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, John Bonesio <bones@secretlab.ca>,
	linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2010 at 10:56 PM, Kyle Moffett <kyle@moffetthome.net> wrote:
> On Tue, Nov 16, 2010 at 15:49, John Bonesio <bones@secretlab.ca> wrote:
>> Pull in recent changes from the main dtc repository. These changes primarily
>> allow multiple device trees to be declared which are merged by dtc. This
>> feature allows us to include a basic dts file and then provide more information
>> for the specific system through the merging functionality.
>
> Hmm, is there some documentation for how to use this feature?
> Specifically I have a custom board with multiple discrete computers on
> it which are only very slightly physically different from each other
> and I'd like to be able to avoid maintaining 2 nearly-exact copies of
> the same DTS file.

Not yet, but there will be.

g.
