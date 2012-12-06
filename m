Return-Path: <geoff@infradead.org>
Message-ID: <1354832676.4015.3.camel@clam>
Subject: Re: [PATCH 13/20] ALSA: sound/ps3: remove __dev* attributes
From: Geoff Levand <geoff@infradead.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Date: Thu, 06 Dec 2012 14:24:36 -0800
In-Reply-To: <1354815329-20221-14-git-send-email-wfp5p@virginia.edu>
References: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
 <1354815329-20221-14-git-send-email-wfp5p@virginia.edu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-12-06 at 12:35 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
> 
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: cbe-oss-dev@lists.ozlabs.org
> ---
>  sound/ppc/snd_ps3.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Looks OK for PS3.

Acked-by: Geoff Levand <geoff@infradead.org>
