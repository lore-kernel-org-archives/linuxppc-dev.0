To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'Jerry Van Baren'" <vanbaren_gerald@si.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'laitingwai@yahoo.com'" <laitingwai@yahoo.com>
Subject: Re: Can I run linux without a file system?
References: <C08678384BE7D311B4D70004ACA371050B76351E@amer22.avnet.com>
From: Roland Dreier <roland@topspin.com>
Date: 21 Jun 2002 14:26:10 -0700
In-Reply-To: <C08678384BE7D311B4D70004ACA371050B76351E@amer22.avnet.com>
Message-ID: <52znxoe32l.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "John" == John Kerl <Kerl> writes:

    John> * I could bulk-copy (cp -R) from $xroot to the filesystem
    John> image, *but* you can't cp around the files in /dev.  The
    John> script below is hackish in that I list out all the
    John> subdirectories in $xroot except /dev and copy them, then
    John> populate /dev using the mkdevs script (included after
    John> mkramdisk).  (It would be more elegant to use find with grep
    John> -v /dev.)

cp -a works like cp -R except it will copy /dev and symlinks properly.

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
