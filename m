Return-Path: <vincent@vinc17.org>
Received: from ay.vinc17.org (jlefevre.net1.nerim.net [80.65.226.245])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0309867B1D
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2005 05:58:09 +1000 (EST)
Date: Mon, 11 Apr 2005 21:42:14 +0200
From: Vincent Lefevre <vincent@vinc17.org>
To: Colin Leroy <colin@colino.net>
Message-ID: <20050411194214.GE2603@ay.vinc17.org>
References: <1113184854.9567.522.camel@gaston>
	<20050411101853.7f0e9385@colin.toulouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050411101853.7f0e9385@colin.toulouse>
Cc: Andrew Morton <akpm@osdl.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] pmac: Improve sleep code of tumbler driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2005-04-11 10:18:53 +0200, Colin Leroy wrote:
> I suppose it also fixes the occasionnal loud static noise that
> sometimes at wakeup, for example on iBook G4s. Good :)

Could this be related to this bug?

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=244467

-- 
Vincent Lefèvre <vincent@vinc17.org> - Web: <http://www.vinc17.org/>
100% accessible validated (X)HTML - Blog: <http://www.vinc17.org/blog/>
Work: CR INRIA - computer arithmetic / SPACES project at LORIA
