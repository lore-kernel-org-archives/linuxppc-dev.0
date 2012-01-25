Return-Path: <msalter@redhat.com>
Subject: Re: [RFCv2 00/14]
From: Mark Salter <msalter@redhat.com>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Jan 2012 17:53:29 -0500
In-Reply-To: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset="us-ascii"
Message-ID: <1327532011.24169.6.camel@deneb.redhat.com>
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-01-23 at 14:07 -0700, Grant Likely wrote:
> Hey everyone,
> 
> Here's the second RFC for the irq_domain patches.  I could use some
> help testing now.  I still expect there will be a few bugs.  The
> series is based on v3.3-rc1, and I've pushed it out to my git server:

Hi Grant,

I converted arch/c6x over to the generic irq_domain support and have not
had any problems in testing. The c6x virtual irq support was a nearly
identical copy of the powerpc code, so the patch I ended up with mostly
copied what you did in arch/powerpc. The c6x patch is on the tip of:

  git@linux-c6x.org:/git/projects/linux-c6x-upstreaming irq-testing

I think this probably belongs in your series, but I can push it
separately if not.

--Mark
