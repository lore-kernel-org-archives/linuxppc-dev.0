Return-Path: <ebs@ebshome.net>
Date: Mon, 3 Apr 2006 15:17:23 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Ralph Blach <ralph.blach@gmail.com>
Subject: Re: where do applications get loaded in virtual memory on a 4xx?
Message-ID: <20060403221723.GB32233@gate.ebshome.net>
References: <b06339d40604030546u4d6192faubca0c63cbaaef741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b06339d40604030546u4d6192faubca0c63cbaaef741@mail.gmail.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 03, 2006 at 08:46:13AM -0400, Ralph Blach wrote:
> I would like to know where in virtual memory application get loaded.
> I can do an NM and see the address in an a.out file?  How do these address
> actually translate to 4xx virtual address?

There is nothing 4xx specific here.

cat /proc/<pid>/maps

-- 
Eugene
