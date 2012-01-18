Return-Path: <mmarek@suse.cz>
Message-ID: <4F1699FE.5050005@suse.cz>
Date: Wed, 18 Jan 2012 11:07:58 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] Kbuild: Use dtc's -d (dependency) option
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
 <1326134295-15547-2-git-send-email-swarren@nvidia.com>
 <1326310587.2535.291.camel@deneb.redhat.com> <4F1206F1.5090405@suse.cz>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D2255@HQMAIL01.nvidia.com>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17801D2255@HQMAIL01.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonas Bonn <jonas@southpole.se>, Jon Loeliger <jdl@jdl.com>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <a-jacquiot@ti.com>,
 Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>, Rob Herring <rob.herring@calxeda.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Mark Salter <msalter@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux@openrisc.net" <linux@openrisc.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17.1.2012 18:20, Stephen Warren wrote:
> Michal Marek wrote at Saturday, January 14, 2012 3:51 PM:
>> As the C6X port has been merged in this merge window, I can't easily
>> apply this patch to my kbuild branch and at the same time please Linus
>> by basing the pull request on a tagged release. So I'm going to drop the
>> arch/c6x part to keep the kbuild branch "pretty" and let either Mark or
>> Stephen send the patch to Linus directly, once he has merged the kbuild
>> branch. Would that work?
> 
> I was assuming my patches were for 3.4 rather than 3.3, since it's pretty
> late for new features in 3.3. In that case, there wouldn't be an issue,
> right?

OK, that was a misunderstanding then. I applied it to the kbuild branch
for 3.3 and Linus pulled it in the meantime. It's not a terribly
intrusive change, after all.

Michal
